# HTML Coding Style

The following guidelines cover how to write HTML example code for frontend development

<!-- TOC -->

* [HTML Coding Style](#html-coding-style)
  * [Common Information](#common-information)
  * [Formatting](#formatting)
  * [Doctype](#doctype)
  * [Document characterset](#document-characterset)
  * [Document Language](#document-language)
  * [Viewport Meta Tag](#viewport-meta-tag)
  * [Indents](#indents)
  * [Line Length](#line-length)
  * [Case](#case)
  * [Class and ID Names](#class-and-id-names)
  * [Quote Attribute Values in HTML](#quote-attribute-values-in-html)
  * [Spaces between equal signs in HTML](#spaces-between-equal-signs-in-html)
  * [Boolean attributes](#boolean-attributes)
  * [Comments](#comments)
    * [Single-line Comments](#single-line-comments)
    * [Multi-line Comments](#multi-line-comments)
    * [Sensitive Information](#sensitive-information)
  * [Best Practices](#best-practices)
  
<!-- TOC -->

## Common Information

A consistent, clean, and tidy HTML code makes it easier for others to read and understand your code.

Here are some guidelines and tips for creating good HTML code:

- Use HTML5 semantic tags [Semantic Elements](https://developer.mozilla.org/en-US/docs/Glossary/Semantics#semantic_elements)
- Avoid an excessive [DOM size](https://developer.chrome.com/docs/lighthouse/performance/dom-size/?utm_source=lighthouse&utm_medium=lr)
- Follow accessibility best practices [HTML and accessibility](https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML)

## Formatting

It is recommended to use Prettier as a code formatter to keep the code style consistent.

[Here is an example](assets/.prettierrc.json) of our configuration file to learn about the current rules, and read the [Prettier documentation](https://prettier.io/docs/en/index.html).

Prettier formats all the code and keeps the style consistent. Nevertheless, there are a few additional rules that you need to follow.

Also, you can use [EditorConfig](https://editorconfig.org/) file for your Code Editor. Here is an example file of [.editorconfig](assets/.editorconfig).

## Doctype

You should use the [HTML5](https://dev.w3.org/html5/spec-LC/) doctype. It is short, easy to remember, and backwards compatible.

## Document characterset

You should also define your document's characterset like so:

```HTML
<meta charset="utf-8" />
```

## Document Language

Set the document language using the [lang](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes#lang) attribute on your [<html>](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/html) element:

```HTML

<html lang="en-US"></html>

```

## Viewport Meta Tag

You should include the following [<meta>](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/meta) viewport element in all your web pages:

```HTML

<meta name="viewport" content="width=device-width" />

```

## Indents

- **Don't use tabs** to indent text; use spaces only. Different text editors interpret tabs differently, and some Markdown features expect spaces and not tabs.
- **Indent by two spaces** per indentation level.
- **Don't leave trailing spaces** at the end of a line (except as needed for Markdown).

## Line Length

Break lines at 80 characters except in the following cases:

- The metadata tags at the top of files (such as page.metaDescription) have to be all on one line, so those lines can be as long as needed.
- If a URL in a link has a line break, the link won't work. If a URL is longer than 80 characters (quite common), you're stuck with it. In that case, put the URL on its own line with the href attribute to make it easier to review the text before and after, as the following example shows:

```HTML
You can find more information in
<a href="https://example.com/long-url/johan-gambolputty-de-von-ausfern-…-von-hautkopf-of-ulm.html"
class="external">his biography.</a>
```

## Case

Use lowercase for all element names and attribute names/values because it looks neater and means you can write markup faster. For example:

✅ ***Good***

```HTML
<p class="nice">This looks nice and neat</p>
```

❌ ***Bad***

```HTML
<P CLASS="WHOA-THERE">Why is my markup shouting?</P>
```

## Class and ID Names

Use semantic class/ID/attributes names, with kebab-case style. Don't use camelCase or any other case. For example:

✅ ***Good***

```HTML
<p class="editorial-summary">Blah blah blah</p>
```

❌ ***Bad***

```HTML
<p class="bigRedBox">Blah blah blah</p>
```

✅ ***Good***

```HTML
<a href="https://data-flair.training/">Welcome to DataFlair</a>
```

❌ ***Bad***

```HTML
<a HREF="https://data-flair.training/">Welcome to DataFlair</a>
```

## Quote Attribute Values in HTML

Always use quotes for attributes:

```HTML
<table class="bordered">
```

❌ ***Bad***

```HTML
<table class= bordered>
```

Use double quotes for HTML, not single quotes, like so:

✅ ***Good***

```HTML
<p class="important">Yes</p>
```

❌ ***Bad***

```HTML
<p class='important'>Nope</p>
```

## Spaces between equal signs in HTML

Though it is allowed to use spaces within equal signs, it is highly recommended not to do so since it disrupts the readability of the code.

✅ ***Good***

```HTML
<a href="https://data-flair.training/">Welcome to DataFlair</a>
```

❌ ***Bad***

```HTML
<a href = "https://data-flair.training/">Welcome to DataFlair</a>
```

## Boolean attributes

Don't write out boolean attributes in full; you can just write the attribute name to set it. For example, you can write:

✅ ***Good***

```HTML
required
```

❌ ***Bad***

```HTML
required="required"
```

## Comments

### Single-line Comments

Single-line comments must be on one line and text inside must be surrounded by spaces.

✅ ***Good***

```HTML
<!--
This is a comment
-->
```

❌ ***Bad***

```HTML
<!-- This is a comment -->
```

### Multi-line Comments

Multi-line comments must start and end on their own line and text must not be indented.


✅ ***Good***

```HTML
<!--
This is a comment
that spans multiple lines
-->
```

❌ ***Bad***

```HTML
<!-- This is a comment
that spans multiple lines
-->
```

### Sensitive Information

Sensitive information must not be placed in a comment.

❌ ***Bad***

```HTML
<!-- Generated by some_php_function() -->
```
Incorrect because comment reveals that markup comes from some_php_function().

## Best Practices

Valid HTML:

✅ ***Good***

```HTML
<ul><li></li></ul>
```

❌ ***Bad***

```HTML
<ul><p></p></ul>
```

Use semantic tags:


✅ ***Good***

```HTML
<a href="">View Options</a>
```

❌ ***Bad***

```HTML
<div class="click">View Options</div>
```

It is better to use snake_case for name form field. But keep in mind that it depends on server requirements.

✅ ***Good***

```HTML
<input type="text" name="first_name">
```

❌ ***Bad***

```HTML
<input type="text" name="firstName">
```

Do not close self-closing elements:

✅ ***Good***

```HTML
<link href="theme.css" rel="stylesheet">

<br>
```

❌ ***Bad***

```HTML
<link href="theme.css" rel="stylesheet" />

<br />
```
