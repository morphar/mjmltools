import tmp_lodash from 'lodash'
const { reduce } = tmp_lodash
import { initializeType } from '../types/type.js'

export default (attributes, allowedAttributes) =>
  reduce(
    attributes,
    (acc, val, attrName) => {
      if (allowedAttributes && allowedAttributes[attrName]) {
        const TypeConstructor = initializeType(allowedAttributes[attrName])

        if (TypeConstructor) {
          const type = new TypeConstructor(val)

          return {
            ...acc,
            [attrName]: type.getValue(),
          }
        }
      }

      return {
        ...acc,
        [attrName]: val,
      }
    },
    {},
  )
