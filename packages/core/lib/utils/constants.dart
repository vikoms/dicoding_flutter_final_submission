const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
const String BASE_IMAGE_URL_CAROUSEL = "https://image.tmdb.org/t/p/w780";

const API_KEY = 'api_key=b807fc0668b99af6a06ea5e34423da26';
const BASE_URL = 'https://api.themoviedb.org/3';

class ThumbnailHelper {
  static String getThumbnailUrl(String videoId) {
    return "https://img.youtube.com/vi/$videoId/maxresdefault.jpg";
  }
}
