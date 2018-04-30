<p align="center">
    <img src="https://user-images.githubusercontent.com/1342803/36623515-7293b4ec-18d3-11e8-85ab-4e2f8fb38fbd.png" width="320" alt="API Template">
    <br>
    <br>
    <a href="http://docs.vapor.codes/3.0/">
        <img src="http://img.shields.io/badge/read_the-docs-2196f3.svg" alt="Documentation">
    </a>
    <a href="http://vapor.team">
        <img src="http://vapor.team/badge.svg" alt="Slack Team">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://circleci.com/gh/vapor/api-template">
        <img src="https://circleci.com/gh/vapor/api-template.svg?style=shield" alt="Continuous Integration">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
</center>

## Gotchas

I had no success using Docker, so I installed a local instance of MySQL with homebrew

`brew tap homebrew/services`

`brew install mysql`

`brew services start mysql`

And then I could log in to MySQL in the terminal with:

`mysql -u root -p`

(hit enter twice)

Once logged in to MySQL I could create a user with:

`GRANT ALL PRIVILEGES ON *.* TO 'til'@'localhost' IDENTIFIED BY 'password';`

And create a DB with:

`CREATE DATABASE vapor;`

And that should be it :smile:
