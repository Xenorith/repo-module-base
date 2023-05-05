package main

import (
	"flag"
	"gopkg.in/yaml.v3"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"runtime"
	"strings"

	"github.com/palantir/stacktrace"
)

func main() {
	repoRoot, err := findRepoRoot()
	if err != nil {
		log.Println(err)
		os.Exit(1)
	}

	cmd := flag.NewFlagSet("", flag.ExitOnError)
	var profilePath string
	cmd.StringVar(&profilePath, "profilePath", filepath.Join(repoRoot, "scripts/tarball-profile.yml"), `path to profiles.yml file`)
	if err := cmd.Parse(os.Args); err != nil {
		log.Println(err)
		os.Exit(1)
	}

	prof, err := loadProfile(profilePath)
	if err != nil {
		log.Println(err)
		os.Exit(1)
	}

	if err := prof.BuildTarball(repoRoot); err != nil {
		log.Println(err)
		os.Exit(1)
	}
}

func loadProfile(profilePath string) (*BuildProfile, error) {
	log.Printf("Loading profile from %v", profilePath)
	content, err := ioutil.ReadFile(profilePath)
	if err != nil {
		return nil, stacktrace.Propagate(err, "error reading file at %v", profilePath)
	}
	var ret BuildProfile
	if err := yaml.Unmarshal(content, &ret); err != nil {
		return nil, stacktrace.Propagate(err, "error deserializing content\n%v", string(content))
	}
	return &ret, nil
}

type BuildProfile struct {
	PathsToCopy []string `yaml:"pathsToCopy"`
}

func (prof *BuildProfile) BuildTarball(repoRoot string) error {
	ver, err := versionFromPom(repoRoot)
	if err != nil {
		return stacktrace.Propagate(err, "error finding version")
	}
	log.Printf("Version: %v", ver)

	log.Println("Building tarball")
	mvnCmd := exec.Command("mvn", "clean", "install")
	mvnCmd.Dir = repoRoot
	if err := mvnCmd.Run(); err != nil {
		return stacktrace.Propagate(err, "error building jars with maven")
	}

	log.Println("Copying tarball contents")
	const tarballDirName = "tarball"
	tarballDir := filepath.Join(repoRoot, tarballDirName)
	if err := os.MkdirAll(tarballDir, os.ModePerm); err != nil {
		return stacktrace.Propagate(err, "error creating directory %v", tarballDir)
	}
	defer os.RemoveAll(tarballDir)

	for _, p := range prof.PathsToCopy {
		replacedPath := strings.Replace(p, verisonPlaceholder, ver, -1)
		dst := filepath.Join(repoRoot, tarballDirName, replacedPath)
		if err := os.MkdirAll(filepath.Dir(dst), os.ModePerm); err != nil {
			return stacktrace.Propagate(err, "error creating parent directory of %v", dst)
		}
		if err := exec.Command("cp", "-r", filepath.Join(repoRoot, replacedPath), dst).Run(); err != nil {
			return stacktrace.Propagate(err, "error copying %v to %v", replacedPath, dst)
		}
	}

	log.Println("Creating tarball")
	tarballPath := filepath.Join(repoRoot, "tarball.tgz")
	if err := os.RemoveAll(tarballPath); err != nil {
		return stacktrace.Propagate(err, "error deleting path %v", tarballPath)
	}
	tarCmd := exec.Command("tar", "-czf", tarballPath, tarballDirName)
	tarCmd.Dir = repoRoot
	if err := tarCmd.Run(); err != nil {
		return stacktrace.Propagate(err, "error creating tarball at %v", tarballPath)
	}
	log.Printf("Tarball created at %v", tarballPath)
	return nil
}

func findRepoRoot() (string, error) {
	// navigate 6 parent directories to reach repo root,
	// assuming this go file is located in <repoRoot>/scripts/src/github.com/xenorith/build/repo.go
	const repoRootDepth = 6
	_, repoRoot, _, ok := runtime.Caller(0)
	if !ok {
		return "", stacktrace.NewError("error getting call stack")
	}
	for i := 0; i < repoRootDepth; i++ {
		repoRoot = filepath.Dir(repoRoot)
	}
	log.Printf("Repository root at directory: %v", repoRoot)
	return repoRoot, nil
}

const verisonPlaceholder = "${VERSION}"

var versionRe = regexp.MustCompile(".*<version>(.*)</version>.*")

func versionFromPom(repoRoot string) (string, error) {
	rootPomPath := filepath.Join(repoRoot, "pom.xml")
	contents, err := ioutil.ReadFile(rootPomPath)
	if err != nil {
		return "", stacktrace.Propagate(err, "error reading %v", rootPomPath)
	}
	matches := versionRe.FindStringSubmatch(string(contents))
	if len(matches) < 2 {
		return "", stacktrace.NewError("did not find any matching version tag in %v", rootPomPath)
	}
	return matches[1], nil
}
