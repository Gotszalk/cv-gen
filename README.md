# CV Generator

This is tool to generate CV using XSL transformations from content in XML. Output file is html with styles in css, which can be printed to PDF using the browser.

Tested on Linux with xsltproc, Chromium and Firefox.

It addresses following needs:
- CV content in text format or similar that can be easily edited using any text editor,
- content stored in home network repo with version control,
- tagged content so it can be filtered depending on needs eg. long/short format, hide/show specific sections/entries,
- PDF as output format.

## Requirements
- XSLT procesor that allows passing params eg. xsltproc on Linux
- modern browser eg. Chromium
- virtual PDF Printer (print to PDF)

## Generating flow
CV generation workflow is as follows:

XML --(XSLT processor)--> HTML --(print to PDF)--> PDF

## Execution
To run the process on Linux with example data it is enough to execute the script:
```
./scripts/make
```
Make sure script file has executable permission. If not just run:
```
chmod +x ./scripts/make
```
Script contains example usage with long/short format options and "tech" filtering as an example.

Every html version contains js script to print the document as soon as it is loaded. Then just choose PDF Printer and save file.

## CV creation process

### Create own CV content
Change ./xsl/cv-en.xml file to reflect your desired content.

### Adjust template
If you need to change the layout, edit following sections
```
<xsl:template>
...
</xsl:template>
```
in  ./xsl/cv.xsl file and change styles in ./html/style.css

Probably the easiest way will be first experiment on copy of one of ./html/*.html files and style.css.

### Run XSLT processor
You can use existing ./script/make on Linux with xsltproc or any other XSLT processor. Ideally, it should support parameters passing but if it doesn't you can always change cv/default settings in ./xsl/cv-en.xsl and use the default settings.

### Generate PDF file
After successful XSLT processing there will be ready ./html/*.html files. Each contains js code to print the content as soon as it is loaded. This is manual step to save ready PDF file

## Known issues
1. In some cases, the content may overlap with footer section on PDF as it is rendered in the browser. Then it requires content or style changes to enforce correct content paging. However, it is rare.
2. Chromium initiated from the terminal may display errors but it does not impact the PDF creation.
3. Firefox does not support css widow used to enforce paging. In effect, depending on content, footer section may overlap the main content as in 1. Changes to content and styles may help.

## ToDo

1. Negative filtering e.g. tagging content to be hidden if specific filtering is used even in default context.
2. Redo the solution to use with Python and JSON.
