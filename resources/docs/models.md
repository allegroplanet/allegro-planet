## Models

```
- User
  - username
  - email
  - first_name
  - last_name
  - description (markdown)
  - password_digest

- UserSession
  - username
  - email
  - ip
  - last_activity_datetime

- Game
  - title
  - developer_id
  - has_many game_screenshots
  - has_many tags

- GameScreenshot
  - filename
  - belongs_to game

- GameRelease
  - version_num
  - description
  - game_id

- GameFile
  - release_id
  - filename
  - type (MacOS binary, Win binary, Linux binary, Data file, Source files)

- Tag
  - title
```
