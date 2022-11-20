import { Social, SocialElement } from '../mjml-social/index.js'
import { Navbar, NavbarLink } from '../mjml-navbar/index.js'
import { Carousel, CarouselImage } from '../mjml-carousel/index.js'
import {
  Accordion,
  AccordionElement,
  AccordionText,
  AccordionTitle,
} from '../mjml-accordion/index.js'
import Body from '../mjml-body/index.js'
import Head from '../mjml-head/index.js'
import HeadAttributes from '../mjml-head-attributes/index.js'
import HeadBreakpoint from '../mjml-head-breakpoint/index.js'
import HeadHtmlAttributes from '../mjml-head-html-attributes/index.js'
import HeadFont from '../mjml-head-font/index.js'
import HeadPreview from '../mjml-head-preview/index.js'
import HeadStyle from '../mjml-head-style/index.js'
import HeadTitle from '../mjml-head-title/index.js'
import Hero from '../mjml-hero/index.js'
import Button from '../mjml-button/index.js'
import Column from '../mjml-column/index.js'
import Divider from '../mjml-divider/index.js'
import Group from '../mjml-group/index.js'
import Image from '../mjml-image/index.js'
import Raw from '../mjml-raw/index.js'
import Section from '../mjml-section/index.js'
import Spacer from '../mjml-spacer/index.js'
import Text from '../mjml-text/index.js'
import Table from '../mjml-table/index.js'
import Wrapper from '../mjml-wrapper/index.js'
import dependencies from './dependencies.js'

const components = [
  Body,
  Head,
  HeadAttributes,
  HeadBreakpoint,
  HeadHtmlAttributes,
  HeadFont,
  HeadPreview,
  HeadStyle,
  HeadTitle,
  Hero,
  Button,
  Column,
  Divider,
  Group,
  Image,

  Raw,
  Section,
  Spacer,
  Text,
  Table,
  Wrapper,

  Social,
  SocialElement,
  Navbar,
  NavbarLink,
  Accordion,
  AccordionElement,
  AccordionText,
  AccordionTitle,
  Carousel,
  CarouselImage,
]

const presetCore = {
  components,
  dependencies,
}

export default presetCore
