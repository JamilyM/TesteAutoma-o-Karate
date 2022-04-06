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

@updatePet
Scenario: Update a pet in the store with form data

    * def addPet = call read('users.feature@addPet')
    Given path 'pet/' + addPet.id
    And form field name = 'Luna'
    And form field status = 'pending'
    When method post
    Then status 200

    * def id = response.message

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

Scenario: Find pet by ID

    * def addPet = call read('users.feature@updatePet')
    Given path 'pet/' + updatePet.id
    When method get
    Then status 200
    And match response.name == 'Luna'





