import tmp_lodash from 'lodash'
const { mapValues } = tmp_lodash

/**
 * Convert "true" and "false" string attributes values
 * to corresponding Booleans
 */

export default function convertBooleansOnAttrs(attrs) {
  return mapValues(attrs, (val) => {
    if (val === 'true') {
      return true
    }
    if (val === 'false') {
      return false
    }

    return val
  })
}
