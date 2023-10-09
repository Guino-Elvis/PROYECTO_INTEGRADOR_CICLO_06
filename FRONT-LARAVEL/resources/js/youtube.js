// youtube.js

window.getYoutubeVideoId = function(url) {
    $queryString = parse_url($url, PHP_URL_QUERY);
    parse_str($queryString, $params);
    if (isset($params['v'])) {
        return $params['v'];
    }
    return null;
}
