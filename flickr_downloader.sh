#!/bin/bash

API_KEY="YOUR_API_KEY"

FLICKR_API_BASE_URL="https://www.flickr.com/services/rest/"
FORMAT="json"
NO_JSON_CALLBACK="1"

IFS= read -rp "Method (1: people, 2: favorites): " input_method
IFS= read -rp "User ID: " user_id
IFS= read -rp "Output dir: " output_dir
IFS= read -rp "Per page: " per_page
IFS= read -rp "Page number: " page

declare -A methods
methods=(["1"]="flickr.people.getPhotos" ["2"]="flickr.favorites.getList")

per_page=${per_page:-100}
page=${page:-1}
input_method=${input_method:-1}
list_method="${methods[$input_method]}"

function generate_flickr_api_url {
  local method=$1
  shift 1
  local params="$*"
  local url="$FLICKR_API_BASE_URL?method=$method&api_key=$API_KEY&format=$FORMAT&nojsoncallback=$NO_JSON_CALLBACK&$params"
  echo $url
}

function main {
  list_url=$(generate_flickr_api_url "$list_method" "user_id=$user_id&per_page=$per_page&page=$page")
  list_response=$(curl -s "$list_url")
  photo_ids=($(echo "$list_response" | jq -r '.photos.photo[].id'))

  # in case using photo ids from javascript fetching instead of Flickr API
  # photo_ids=("photo_id_1", "photo_id_2")

  count=0

  for id in "${photo_ids[@]}"
  do
    sizes_url=$(generate_flickr_api_url "flickr.photos.getSizes" "photo_id=$id")
    response=$(curl -s "$sizes_url")

    url=$(echo "$response" | jq -r '.sizes.size[-1].source')
    photo_name="${url##*/}"
    curl -s -o "$output_dir\\$photo_name" "$url"

    ((count++))
    echo "= [$count] Downloaded: $photo_name"

    sleep 0.5
  done

  echo "* Total downloaded files: $count"
}

main