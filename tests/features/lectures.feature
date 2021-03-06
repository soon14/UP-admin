Feature: Operations with lectures

  Background: Prepared database and logged user
    Given the database with some clients, groups, courses and attendance states
    And the logged user


  @add @lectures @fast.row<row.id>
  Scenario Outline: Add valid group lecture
    When user adds new group lecture for group "<group>" with date "<date>", time "<time>", duration "<duration>", canceled "<canceled>", attendance of the client "<client1>" is: "<attendancestate1>", paid "<paid1>", note "<note1>" and attendance of the client "<client2>" is: "<attendancestate2>", paid "<paid2>", note "<note2>"
    Then the lecture is added

    Examples: Lectures
      | group     | date       | time  | canceled | duration | client1        | attendancestate1 | paid1 | note1 | client2         | attendancestate2 | paid2 | note2 |
      | Slabika 4 | 2018-05-07 | 15:00 | False    | 40       | Rodová Petra   | abcd             | False | test  | Jirušková Aneta | OK               | True  | test  |
      | Slabika 4 | 2018-05-07 | 16:00 | False    | 50       | Rodová Petra   | OK               | True  |       | Jirušková Aneta | OK               | True  |       |
      | Slabika 4 | 2018-05-07 | 17:00 | False    | 10       | Rodová Petra   | omluven          | False | test  | Jirušková Aneta | OK               | False | test  |
      | Slabika 4 | 2018-05-07 | 17:10 | True     | 10       | Rodová Petra   | OK               | False | test  | Jirušková Aneta | OK               | False | test  |
      # neaktivni klient
      | Slabika 2 | 2018-05-09 | 20:00 | False    | 10       | Uhlíř Jaroslav | OK               | False | test  | Neaktivní Pavel | OK               | False | test  |


  @add @lectures @fast.row<row.id>
  Scenario Outline: Add valid single lecture
    When user adds new single lecture for client "<client>" for course "<course>" with date "<date>", time "<time>", duration "<duration>", canceled "<canceled>", attendance of the client is: "<attendancestate>", paid "<paid>", note "<note>"
    Then the lecture is added

    Examples: Lectures
      | client          | date       | time  | canceled | course       | attendancestate | paid  | note | duration |
      | Rod Lukáš       | 2018-05-07 | 15:00 | False    | Kurz Slabika | OK              | True  |      | 50       |
      | Rod Lukáš       | 2018-05-07 | 16:00 | False    | Kurz Slabika | abcd            | False | test | 40       |
      | Rod Lukáš       | 2018-05-07 | 17:00 | True     | Kurz Slabika | OK              | False | test | 10       |
      # neaktivni klient
      | Neaktivní Pavel | 2018-05-09 | 20:00 | False    | Kurz Slabika | OK              | False | test | 40       |


  @add @lectures
  Scenario Outline: Add invalid group lecture
    When user adds new group lecture for group "<group>" with date "<date>", time "<time>", duration "<duration>", canceled "<canceled>", attendance of the client "<client1>" is: "<attendancestate1>", paid "<paid1>", note "<note1>" and attendance of the client "<client2>" is: "<attendancestate2>", paid "<paid2>", note "<note2>"
    Then the lecture is not added

    Examples: Lectures
      | group     | date       | time  | canceled | duration | client1      | attendancestate1 | paid1 | note1 | client2         | attendancestate2 | paid2 | note2 |
      # chybi trvani
      | Slabika 4 | 2018-05-07 | 15:00 | False    |          | Rodová Petra | OK               | True  |       | Jirušková Aneta | OK               | True  |       |
      # casovy konflikt
      | Slabika 4 | 2018-05-07 | 20:00 | False    | 10       | Rodová Petra | OK               | False | test  | Jirušková Aneta | OK               | False | test  |
      # neaktivni skupina
      | Slabika 5 | 2018-05-07 | 17:10 | True     | 10       | Rodová Petra | OK               | False | test  | Jirušková Aneta | OK               | False | test  |


  @add @lectures
  Scenario Outline: Add invalid single lecture
    When user adds new single lecture for client "<client>" for course "<course>" with date "<date>", time "<time>", duration "<duration>", canceled "<canceled>", attendance of the client is: "<attendancestate>", paid "<paid>", note "<note>"
    Then the lecture is not added

    Examples: Lectures
      | client    | date       | time  | canceled | course       | attendancestate | paid  | note | duration |
      # chybi trvani
      | Rod Lukáš | 2018-05-07 | 16:00 | False    | Kurz Slabika | OK              | False | test |          |
      # casovy konflikt
      | Rod Lukáš | 2018-05-07 | 20:00 | False    | Kurz Slabika | OK              | False | test | 40       |


  @edit @lectures
  Scenario: Edit single lecture
    When user updates the data of lecture at "2018-05-07", "20:00" to date "2018-05-08", time "21:00", course "Předškolák s ADHD", duration "88", canceled "True", attendance of the client "Rodová Petra" is: "OK", paid "False", note "test"
    Then the lecture is updated


  @edit @lectures
  Scenario Outline: Edit single lecture paid state
    When user updates the paid state of lecture of the client "<client>" at "<date>", "<time>" to "<new_paid>"
    Then the paid state of the attendance is updated

    Examples: Lectures data
      | date       | time  | client       | new_paid |
      | 2018-05-07 | 20:00 | Rodová Petra | False    |
      | 2018-05-07 | 21:00 | Rodová Petra | True     |


  @edit @lectures
  Scenario Outline: Edit single lecture attendance state
    When user updates the attendance state of lecture of the client "<client>" at "<date>", "<time>" to "<new_attendancestate>"
    Then the attendance state of the attendance is updated

    Examples: Lectures data
      | date       | time  | client       | new_attendancestate |
      | 2018-05-07 | 20:00 | Rodová Petra | omluven             |
      | 2018-05-07 | 21:00 | Rodová Petra | omluven             |


  @delete @lectures
  Scenario: Delete lecture
    When user deletes the lecture of the client "Rodová Petra" at "2018-05-07", "20:00"
    Then the lecture is deleted
