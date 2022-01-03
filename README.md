# Code Reading Club information site

[Published site](https://codereading.club)
[Code of conduct](https://codereading.club/conduct)

## Adding or editing content

### Content is provided by markdown files

- [index page](https://github.com/CodeReadingClubs/www/blob/main/content/index.md)
- [Blog pages](https://github.com/CodeReadingClubs/www/blob/main/content/blog)
- Blogs can be in draft (only visible in a dev environment) by adding `"draft": true` to the blog's `.md` file

### Authors are defined with name, avatar and bio required

- [list of authors](https://github.com/CodeReadingClubs/www/blob/main/src/Data/Author.elm)
- Add a new author by adding a new record to the `all` list like this:

```elm
all =
    [ { name = "Author Name"
      , avatar = Pages.images.author.jpegname
      , bio = "Brief biographical info"
      }
    , { name = "Another Author"
      , avatar = Pages.images.author.anotherjpegname
      , bio = "Some biographical info"
      }
    ]
```

### Images files need to be added before they can be used by authors and articles

- [author images](https://github.com/CodeReadingClubs/www/tree/main/images/author)
- [article images](https://github.com/CodeReadingClubs/www/tree/main/images/articles)

## Deploy to Netlify
- When a pull request is created against `main`, netlify builds a preview site
- When code is merged into `main` it is deployed to [current release](https://codereadingclub.netlify.app)

## Development Setup Instructions

- Install: `yarn install`
- Run dev server: `yarn start` (uses `elm-pages develop`)

## Further resource
### Learn more about `elm-pages`

- [Documentation site](https://elm-pages.com)
- [Elm Package docs](https://package.elm-lang.org/packages/dillonkearns/elm-pages/latest/)
- [`elm-pages` blog](https://elm-pages.com/blog)
