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
  * [Case](#case)
  * [Class and ID Names](#class-and-id-names)
  * [Case](#case-1)
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

Also, you can use [EditorConfig](https://editorconfig.org/) file for your Code Editor. Here is an example file of [.editorconfig](assets/.prettierrc.json).

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

## Case

Use lowercase for all element names and attribute names/values because it looks neater and means you can write markup faster. For example:

:white_check_mark: ***Good***

```HTML
<p class="nice">This looks nice and neat</p>
```

:x: ***Bad***

```HTML
<P CLASS="WHOA-THERE">Why is my markup shouting?</P>
```

## Class and ID Names

Use semantic class/ID names, and separate multiple words with hyphens. Don't use camelCase or any other case. For example:

:white_check_mark: ***Good***

```HTML
<p class="editorial-summary">Blah blah blah</p>
```

:x: ***Bad***

```HTML
<p class="bigRedBox">Blah blah blah</p>
```

## Case

Like elements, there is no clear distinction provided by HTML in using upper or lower case names for attributes. However, it is good practice to use lowercase letters for attribute names.

:white_check_mark: ***Good***

```HTML
<a href="https://data-flair.training/">Welcome to DataFlair</a>
```

:x: ***Bad***

```HTML
<a HREF="https://data-flair.training/">Welcome to DataFlair</a>
```

## Quote Attribute Values in HTML

Always use quotes for attributes:

```HTML
<table class="bordered">
```

:x: ***Bad***

```HTML
<table class= bordered>
```

Use double quotes for HTML, not single quotes, like so:

:white_check_mark: ***Good***

```HTML
<p class="important">Yes</p>
```

:x: ***Bad***

```HTML
<p class='important'>Nope</p>
```

## Spaces between equal signs in HTML

Though it is allowed to use spaces within equal signs, it is highly recommended not to do so since it disrupts the readability of the code.

:white_check_mark: ***Good***

```HTML
<a href="https://data-flair.training/">Welcome to DataFlair</a>
```

:x: ***Bad***

```HTML
<a href = "https://data-flair.training/">Welcome to DataFlair</a>
```

## Boolean attributes

Don't write out boolean attributes in full; you can just write the attribute name to set it. For example, you can write:

:white_check_mark: ***Good***

```HTML
required
```

:x: ***Bad***

```HTML
required="required"
```

## Comments

### Single-line Comments

Single-line comments must be on one line and text inside must be surrounded by spaces.

:white_check_mark: ***Good***

```HTML
<!--
This is a comment
-->
```

:x: ***Bad***

```HTML
<!-- This is a comment -->
```

### Multi-line Comments

Multi-line comments must start and end on their own line and text must not be indented.


:white_check_mark: ***Good***

```HTML
<!--
This is a comment
that spans multiple lines
-->
```

:x: ***Bad***

```HTML
<!-- This is a comment
that spans multiple lines
-->
```

### Sensitive Information

Sensitive information must not be placed in a comment.

:x: ***Bad***

```HTML
<!-- Generated by some_php_function() -->
```
Incorrect because comment reveals that markup comes from some_php_function().

## Best Practices

Valid HTML:

:white_check_mark: ***Good***

```HTML
<ul><li></li></ul>
```

:x: ***Bad***

```HTML
<ul><p></p></ul>
```

Semantic tag usage:


:white_check_mark: ***Good***

```HTML
<a href="">View Options</a>
```

:x: ***Bad***

```HTML
<div class="click">View Options</div>
```

Use underscores to separate words:

:white_check_mark: ***Good***

```HTML
<input type="text" name="first_name">
```

:x: ***Bad***

```HTML
<input type="text" name="firstName">
```

Do not close self-closing elements:

:white_check_mark: ***Good***

```HTML
<link href="theme.css" rel="stylesheet">

<br>
```

:x: ***Bad***

```HTML
<link href="theme.css" rel="stylesheet" />

<br />
```
