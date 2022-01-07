module Page.Blog.Slug_ exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import DataSource.File as File
import DataSource.Glob as Glob
import Head
import Head.Seo as Seo
import Html
import OptimizedDecoder as Decode exposing (Decoder)
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    { slug : String }


page : Page RouteParams Data
page =
    Page.prerender
        { head = head
        , routes = routes
        , data = blogData
        }
        |> Page.buildNoState { view = view }


routes : DataSource (List RouteParams)
routes =
    blogPostsGlob
        |> DataSource.map
            (List.map (\globData -> { slug = globData.slug }))


type alias BlogContent =
    { filePath : String
    , slug : String
    }


blogPostsGlob : DataSource.DataSource (List BlogContent)
blogPostsGlob =
    Glob.succeed BlogContent
        |> Glob.captureFilePath
        |> Glob.match (Glob.literal "content/blog/")
        |> Glob.capture Glob.wildcard
        |> Glob.match (Glob.literal ".md")
        |> Glob.toDataSource


blogData : RouteParams -> DataSource Data
blogData routeParams =
    File.bodyWithFrontmatter blogPostDecoder
        ("content/blog/" ++ routeParams.slug ++ ".md")


blogPostDecoder : String -> Decoder Data
blogPostDecoder body =
    Decode.map2 (Data body)
        (Decode.field "title" Decode.string)
        (Decode.field "tags" tagsDecoder)


tagsDecoder : Decoder (List String)
tagsDecoder =
    Decode.map (String.split " ")
        Decode.string


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = static.data.title
        }
        |> Seo.website


type alias Data =
    { body : String
    , title : String
    , tags : List String
    }


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { title = static.data.title
    , body = [ Html.text static.data.body ]
    }
