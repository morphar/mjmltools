import Type from './type.js'

export const matcher = /^integer/gim

export default () =>
  class NInteger extends Type {
    constructor(value) {
      super(value)

      this.matchers = [/\d+/]
    }
  }
