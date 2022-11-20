import NBoolean, { matcher as booleanMatcher } from './boolean.js'
import Color, { matcher as colorMatcher } from './color.js'
import Enum, { matcher as enumMatcher } from './enum.js'
import Unit, { matcher as unitMatcher } from './unit.js'
import NString, { matcher as stringMatcher } from './string.js'
import NInteger, { matcher as intMatcher } from './integer.js'

export default {
  boolean: { matcher: booleanMatcher, typeConstructor: NBoolean },
  enum: { matcher: enumMatcher, typeConstructor: Enum },
  color: { matcher: colorMatcher, typeConstructor: Color },
  unit: { matcher: unitMatcher, typeConstructor: Unit },
  string: { matcher: stringMatcher, typeConstructor: NString },
  integer: { matcher: intMatcher, typeConstructor: NInteger },
}
