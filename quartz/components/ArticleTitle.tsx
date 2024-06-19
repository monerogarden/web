import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import { classNames } from "../util/lang"

const ArticleTitle: QuartzComponent = ({ fileData, displayClass }: QuartzComponentProps) => {
  let title = fileData.frontmatter?.title
  if (title) {
    title = title.replace(/^\d+\.\d+\s*/, '');
  }
  if (title) {
    return <h1 class={classNames(displayClass, "article-title")}>{title.replace(/^\d+\.\d+\s*/, '')}</h1>
  } else {
    return null
  }
}

ArticleTitle.css = `
.article-title {
  margin: 2rem 0 0 0;
}
`

export default (() => ArticleTitle) satisfies QuartzComponentConstructor
