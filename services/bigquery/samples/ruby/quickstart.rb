require "google/cloud/bigquery"

bigquery = Google::Cloud::Bigquery.new

sql = "SELECT " +
      "CONCAT('https://stackoverflow.com/questions/', " +
      "       CAST(id as STRING)) as url, view_count " +
      "FROM `bigquery-public-data.stackoverflow.posts_questions` " +
      "WHERE tags like '%google-bigquery%' " +
      "ORDER BY view_count DESC LIMIT 10"
results = bigquery.query sql

results.each do |row|
  puts "#{row[:url]}: #{row[:view_count]} views"
end
