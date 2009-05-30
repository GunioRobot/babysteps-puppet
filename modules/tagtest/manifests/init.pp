
class tagtest {

  file { "/tagtest":
    content => template("tagtest/tagtest.erb")
  }
}
