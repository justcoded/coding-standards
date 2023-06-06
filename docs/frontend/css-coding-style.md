# Code Styles

<!-- TOC -->

* [Code Styles](#code-styles)
  * [CSS](#css)
    * [SCSS](#scss)
    * [Styles for RTL](#styles-for-rtl)
    * [Units](#units)
  * [Methodology](#methodology)
  
<!-- TOC -->


## CSS

Follow [CSS Guidelines](https://cssguidelin.es/)

Here is some tips that might help:

- Do not be afraid to use new feature CSS. Always check new CSS properties by [Can I Use](https://caniuse.com/)
- For [vendor prefixes](https://developer.mozilla.org/en-US/docs/Glossary/Vendor_Prefix) use [autoprefixer](https://github.com/postcss/autoprefixer) plugin in your build.
- You can use already done patterns from [MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/Layout_cookbook)
- Use [CSS custom properties](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties)
- Use [W3C CSS validator](https://jigsaw.w3.org/css-validator/). Code should be valid!

### Units

You should use [Rem units](https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Values_and_units#percentages) im most common cases. Here is why it is important [Use Rems](https://uxdesign.cc/why-designers-should-move-from-px-to-rem-and-how-to-do-that-in-figma-c0ea23e07a15)
Also, px or em units are not prohibited. You can use px in cases where rem units is not the best solutions. For example, borders, shadows, outlines. breakpoints.


### Methodology

You should follow [BEM Methodology Name Convention](https://en.bem.info/methodology/naming-convention/) for development CSS code. Do not follow strictly rules from methodology. If you see profit of using CSS then use it.


### Class or ID

Class is preferable under the IDs.

Use semantic names for classes:

❌ ***Bad***

```CSS
.awesome-logo {
    display: flex;
}
```

✅ ***Good***

```CSS
.logo {
  display: flex;
}
```

✅ ***Good***

```CSS
.header__logo {
  display: flex;
}
```

### Examples


Be specific with styles:

❌ ***Bad***

```CSS
.logo {
  transition: all 0.5s ease;
}
```

✅ ***Good***

```CSS
.logo {
  transition: opacity 0.5s ease;
}
```

Do not specify your styles with tag selector:

❌ ***Bad***

```CSS
input.btn {}
```

✅ ***Not Recommended but in some case could be used***

```CSS
.btn.btn {}
```

[Use shorthand](https://developer.mozilla.org/en-US/docs/Web/CSS/Shorthand_properties) for CSS properties:

❌ ***Bad***

```CSS
.logo {
  background-color: #000;
  background: url(images/bg.png) no-repeat left top;
}
```

✅ ***Good***

```CSS
.logo {
  background:#000 url(images/bg.png) no-repeat left top;
}
```

## Styles for RTL

Developments tips:

- Follow the best practices from [RTL Styling 101](https://rtlstyling.com/posts/rtl-styling)

- Use [CSS Logical Properties and Values](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Logical_Properties) for layout properties.

❌ ***Bad***

```CSS
.text {
    margin-left: 10px;
}
[dir='rtl'] .text {
  margin-left: 0;
  margin-right: 10px;
}
```

✅ ***Good***

```CSS
.text {
    margin-inline-start: 10px;
}
```

## SCSS

Use the hole power of [SCSS](https://sass-lang.com/) in your project.

SCSS should follow best practices from [SASS Guidelines](https://sass-guidelin.es/)

Do not use [CSS custom properties](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties) instead of [SCSS varibales](https://css-tricks.com/difference-between-types-of-css-variables/)

### Mixins

## Helpful Links

- [Guidelines for styling CSS code examples](https://developer.mozilla.org/en-US/docs/MDN/Writing_guidelines/Writing_style_guide/Code_style_guide/CSS)
- [ID vs. Class CSS: Which Should You Use?](https://www.bestcolleges.com/bootcamps/guides/css-class-vs-id/)
- [High-level advice and guidelines for writing sane, manageable, scalable CSS](https://cssguidelin.es/)
