import tmp_lodash from 'lodash'
const { forEach } = tmp_lodash

export default function setEmptyAttributes(node) {
  if (!node.attributes) {
    node.attributes = {}
  }
  if (node.children) {
    forEach(node.children, setEmptyAttributes)
  }
}
