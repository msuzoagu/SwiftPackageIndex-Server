'use strict'

module.exports = {
    extends: ['stylelint-config-standard-scss'],
    plugins: ['stylelint-order', 'stylelint-scss'],
    rules: {
        'at-rule-no-unknown': null,
        'at-rule-empty-line-before': [
            'always',
            {
                except: ['blockless-after-same-name-blockless', 'first-nested'],
                ignore: ['after-comment'],
                ignoreAtRules: ['else'],
            },
        ],
        'color-function-notation': 'legacy',
        'color-hex-length': 'long',
        'custom-property-empty-line-before': null,
        'declaration-block-no-redundant-longhand-properties': null,
        'declaration-empty-line-before': 'never',
        'font-family-no-duplicate-names': null,
        'max-line-length': null,
        'media-feature-range-notation': 'prefix',
        'no-descending-specificity': null,
        'number-max-precision': null,
        'property-no-vendor-prefix': null,
        'scss/at-rule-no-unknown': true,
        'scss/at-else-closing-brace-space-after': 'always-intermediate',
        'scss/at-else-closing-brace-newline-after': 'always-last-in-chain',
        'scss/at-else-empty-line-before': 'never',
        'scss/at-if-closing-brace-space-after': 'always-intermediate',
        'scss/at-if-closing-brace-newline-after': 'always-last-in-chain',
        'scss/comment-no-empty': null,
        'selector-class-pattern': '^([a-z][a-z0-9]*)(-[a-z0-9]+)*$',
        'selector-id-pattern': '^([a-z][a-z0-9]*)(-[a-z0-9]+)*$',
        'selector-not-notation': 'simple',
        'value-keyword-case': null,
        'order/order': ['dollar-variables', 'custom-properties', 'declarations', 'rules', 'at-rules'],
        'order/properties-order': [
            [
                'content',
                'src',
                'position',
                'top',
                'bottom',
                'left',
                'right',
                'z-index',
                'clear',
                'float',
                'display',
                'appearance',
                'vertical-align',
                'visibility',
                'opacity',
                'overflow',
                'overflow-x',
                'overflow-y',
                'cursor',
                'pointer-events',
                'user-select',
                'speak',
                'speak-as',
                'grid-template',
                'grid-template-columns',
                'grid-template-rows',
                'grid-template-areas',
                'grid-column',
                'grid-column-start',
                'grid-column-end',
                'grid-row',
                'grid-row-start',
                'grid-row-end',
                'grid-area',
                'grid-auto-flow',
                'flex',
                'flex-direction',
                'flex-wrap',
                'flex-basis',
                'flex-grow',
                'flex-shrink',
                'gap',
                'column-gap',
                'row-gap',
                'align-content',
                'align-items',
                'align-self',
                'justify-content',
                'justify-items',
                'justify-self',
                'place-content',
                'place-items',
                'place-self',
                'width',
                'max-width',
                'min-width',
                'height',
                'max-height',
                'min-height',
                'aspect-ratio',
                'margin',
                'margin-top',
                'margin-bottom',
                'margin-left',
                'margin-right',
                'padding',
                'padding-top',
                'padding-bottom',
                'padding-left',
                'padding-right',
                'direction',
                'font',
                'font-display',
                'font-family',
                'font-size',
                'font-style',
                'font-variant',
                'font-weight',
                'letter-spacing',
                'line-height',
                'text-align',
                'text-decoration',
                'text-transform',
                'white-space',
                'word-break',
                'word-spacing',
                'word-wrap',
                'fill',
                'color',
                'mask',
                'mask-clip',
                'mask-composite',
                'mask-mode',
                'mask-origin',
                'mask-position',
                'mask-repeat',
                'mask-size',
                'mask-image',
                'mask-border',
                'mask-border-mode',
                'mask-border-repeat',
                'mask-border-slice',
                'mask-border-source',
                'mask-border-width',
                'background',
                'background-position',
                'background-repeat',
                'background-size',
                'background-blend-mode',
                'background-color',
                'background-image',
                'border',
                'border-collapse',
                'border-inline',
                'border-radius',
                'border-style',
                'border-width',
                'border-color',
                'border-image',
                'border-image-outset',
                'border-image-repeat',
                'border-image-slice',
                'border-image-source',
                'border-image-width',
                'border-top',
                'border-top-style',
                'border-top-width',
                'border-top-color',
                'border-bottom',
                'border-bottom-style',
                'border-bottom-width',
                'border-bottom-color',
                'border-left',
                'border-left-style',
                'border-left-width',
                'border-left-color',
                'border-right',
                'border-right-style',
                'border-right-width',
                'border-right-color',
                'border-top-left-radius',
                'border-top-right-radius',
                'border-bottom-left-radius',
                'border-bottom-right-radius',
                'box-shadow',
                'box-sizing',
                'outline',
                'outline-style',
                'outline-width',
                'outline-color',
                'list-style',
                'list-style-image',
                'list-style-position',
                'list-style-type',
                'transform',
                'transform-box',
                'transform-origin',
                'transform-style',
                'animation',
                'animation-delay',
                'transition',
                'transition-duration',
                'transition-property',
                'transition-timing-function',
                'will-change',
                'clip-path',
            ],
            { unspecified: 'bottomAlphabetical' },
        ],
    },
}
