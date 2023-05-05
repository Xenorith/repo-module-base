# Docs
Documentation is written in markdown and converted to HTML using [jekyll](https://jekyllrb.com/).

The file `Dynamic.md` demonstrates how to include the content of another markdown file if the file path exists.

- [`include_relative`](https://jekyllrb.com/docs/includes/#including-files-relative-to-another-file)
will read and insert the content of the given file, relative to the current file's location.
- `file_exists` is a custom ruby function to return `"true"` if the file path exists.
The function is defined in the `_plugins/` directory.

Combining these two features, the template code looks like:
```
{% capture exists %}{% file_exists root/path/to/file %}{% endcapture %}
{% if exists == "true" %}
{% include_relative relative/path/to/file %}
{% endif %}
```

In the case another repository wants to reuse most of the file's content, this template allows for 3 scenarios:
- a section of the file can be substituted with different content by replacing the target file
- a section of the file can be removed by deleting the target file
- a placeholder section of the file can be defined to be populated when the target file exists
