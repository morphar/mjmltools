import Type from './type.js'

export const matcher = /^string/gim

export default () =>
  class NString extends Type {
    constructor(value) {
      super(value)

      this.matchers = [/.*/]
    }
  }
