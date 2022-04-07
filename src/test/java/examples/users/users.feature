Feature: sample karate test script

Background:
* url 'https://petstore.swagger.io/v2'

@addPet
Scenario: Add a new pet to the store

    * def addPet =
    """
      {
        "id": 0,
        "category": {
          "id": 0,
          "name": "string"
        },
        "name": "doggie",
        "photoUrls": [
          "string"
        ],
        "tags": [
          {
            "id": 0,
            "name": "string"
          }
        ],
        "status": "available"
      }

    """
    Given path 'pet'
    And request addPet
    When method post
    Then status 200
     
    * def id = response.id
    * print 'created id is: ', id

Scenario Outline: Finds Pets by Status
  
  Given path 'pet/findByStatus'
  And param status = <status>
  When method get
  Then status 200
  * match response[0].status == <status>
  Examples:
     |  status   |      
     | "pending" |
     |"available"|
     |  "sold"   |

Scenario: Update an existing pet

    * def updatePet =
    """
      {
        "id": ,
        "category": {
          "id": 0,
          "name": "string"
        },
        "name": "Luna",
        "photoUrls": [
          "string"
        ],
        "tags": [
          {
            "id": 0,
            "name": "string"
          }
        ],
        "status": "available"
      }

    """

    Given path 'pet'
    And request updatePet
    When method put
    Then status 200
     
    * def name = response.name
    * print 'current name: ', name

@updatePet
Scenario: Update a pet in the store with form data

    * def addPet = call read('users.feature@addPet')
    Given path 'pet/' + addPet.id
    And form field name = 'Luna'
    And form field status = 'pending'
    When method post
    Then status 200
    * def id = response.message

Scenario: Find pet by ID

    * def updatePet = call read('users.feature@updatePet')
    Given path 'pet/' + updatePet.id
    When method get
    Then status 200
    And match response.name == 'Luna'

Scenario: Deletes a pet 

   * def addPet = call read('users.feature@addPet')
   Given path 'pet/' + addPet.id
   When method delete
   Then status 200

@addStore
Scenario: Place an order for a pet

    * def store = 
    """
      {
        "id": 0,
        "petId": 0,
        "quantity": 0,
        "shipDate": "2022-04-06T20:30:40.727Z",
        "status": "placed",
        "complete": true
      }
    """
    Given path 'store/order'
    And request store
    When method post
    Then status 200

    * def id = response.id
    * print 'created id is: ', id    

Scenario: Find purchase order by id

    * def addStore = call read('users.feature@addStore')
    Given path 'store/order/' + addStore.id
    When method get
    Then status 200

Scenario: Delete purchase order by id

    * def addStore = call read('users.feature@addStore')
    Given path 'store/order/' + addStore.id
    When method delete
    Then status 200

@createWithList
Scenario: Creates list of users with given input array

    * def randomStringNumber = read('classpath:javascript/random-number-generator.js')
    * def createWithList = 
    """
        [   
          {
            "id": 0,
            "username": "Jamily1718",
            "firstName": "Jamily",
            "lastName": "string",
            "email": "string",
            "password": "string",
            "phone": "string",
            "userStatus": 0
          }
        ]    
    """
    Given path 'user/createWithList'
    * set createWithList[0].id = new java.math.BigDecimal(randomStringNumber(15))
    And request createWithList
    When method post
    Then status 200

    * def username =  createWithList[0].username
    * def firstName = createWithList[0].firstName
    * def id = createWithList[0].id
    * print 'username', username

Scenario: Get user by user name

    * def createWithList = call read('users.feature@createWithList')
    Given path 'user/' + createWithList.username
    When method get
    Then status 200
    * match response.firstName == 'Jamily'

@updateUser
Scenario: Update user

    * def randomStringNumber = read('classpath:javascript/random-number-generator.js')
    * def updateUser = 
    """
        
      {
        "username": "Jamily1718",
        "firstName": "Jamily",
        "lastName": "Melo",
        "email": "string",
        "password": "1707",
        "phone": "string",
        "userStatus": 0
      }
        
    """
    * def createWithList = call read('users.feature@createWithList')
    Given path 'user/' + createWithList.username
    And request updateUser   
    When method put
    Then status 200

    * def username = updateUser.username
    * def password = updateUser.password

Scenario: Delete user

    * def createWithList = call read('users.feature@createWithList')
    Given path 'user/' + createWithList.username   
    When method delete
    Then status 200

Scenario: Login user into the system

    * def updateUser = call read('users.feature@updateUser')
    Given path 'user/login'
    And form field password = updateUser.password
    And form field username = updateUser.username
    When method get
    Then status 200



