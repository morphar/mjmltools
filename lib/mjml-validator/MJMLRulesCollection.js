import validAttributes from './rules/validAttributes.js'
import validChildren from './rules/validChildren.js'
import validTag from './rules/validTag.js'
import validTypes from './rules/validTypes.js'
import errorAttr from './rules/errorAttr.js'

const MJMLRulesCollection = {
  validAttributes,
  validChildren,
  validTag,
  validTypes,
  errorAttr,
}

export function registerRule(rule, name) {
  if (typeof rule !== 'function') {
    return console.error('Your rule must be a function')
  }

  if (name) {
    MJMLRulesCollection[name] = rule
  } else {
    MJMLRulesCollection[rule.name] = rule
  }

  return true
}

export default MJMLRulesCollection
