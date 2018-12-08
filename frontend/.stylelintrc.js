const props = require('./config/stylelintProps');

module.exports = {
  extends: require.resolve('stylelint-config-standard'),
  plugins: [
    require.resolve('stylelint-scss'),
    require.resolve('stylelint-order')
  ],
  rules: {
    'at-rule-empty-line-before': 'never',
    'at-rule-no-unknown': null,
    'declaration-block-semicolon-space-before': null,
    'declaration-empty-line-before': null,
    'no-descending-specificity': null,
    'order/properties-order': [
      {
        emptyLineBefore: 'never',
        order: 'flexible',
        properties: props.blockElement
      },
      {
        emptyLineBefore: 'never',
        order: 'flexible',
        properties: props.boxModel
      },
      {
        emptyLineBefore: 'never',
        order: 'flexible',
        properties: props.text
      },
      {
        emptyLineBefore: 'never',
        order: 'flexible',
        properties: props.decoration
      }
    ],
    'scss/at-rule-no-unknown': true,
    'selector-attribute-quotes': 'always',

    // Prevent selector-pseudo-class-no-unknown and selector-pseudo-element-no-unknown
    'selector-pseudo-class-no-unknown': [
      true,
      {
        ignorePseudoClasses: ['global']
      }
    ],
    'selector-pseudo-element-no-unknown': [
      true,
      {
        ignorePseudoElements: ['global']
      }
    ]
  }
};
