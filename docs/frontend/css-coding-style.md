# Code Styles




## CSS

Follow [CSS Guidelines](https://cssguidelin.es/)

Here is some tips that might help:

- Do not be afraid to use new feature CSS,
- Always check CSS properties by [Can I Use](https://caniuse.com/)
- For [vendor prefixes](https://developer.mozilla.org/en-US/docs/Glossary/Vendor_Prefix) use [autoprefixer](https://github.com/postcss/autoprefixer) plugin in your build.
- You can use already done patterns from [MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/Layout_cookbook)
- Use [CSS custom properties](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties)

### SCSS

Use the hole power of [SCSS](https://sass-lang.com/) in your project.

SCSS should follow best practices from [SASS Guidelines](https://sass-guidelin.es/)

Do not use [CSS custom properties](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties) instead of [SCSS varibales](https://css-tricks.com/difference-between-types-of-css-variables/)

### Styles for RTL

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

### Units

We use [Rem units](https://developer.mozilla.org/en-US/docs/Learn/CSS/Building_blocks/Values_and_units#percentages) as a main unit. Here is why it is important [Use Rems](https://uxdesign.cc/why-designers-should-move-from-px-to-rem-and-how-to-do-that-in-figma-c0ea23e07a15)


## Methodology

We follow [BEM Methodology Name Convention](https://en.bem.info/methodology/naming-convention/) in CSS code.


