json.partial! "comments/comment", comment: @comment
json.id @comment.id
json.user_id @comment.user_id
json.article_id @comment.article_id
json.body @comment.body
json.created @comment.created_at
json.updated @comment.updated_at
json.user do
    json.email @comment.user.email
end