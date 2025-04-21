    #modificado en hotfix
@e2ev
Feature: prueba API crear pedido PET

  Background: Principal
    * configure ssl = true
    * url 'https://petstore.swagger.io/v2'

  @crearv
  Scenario: crear order pet - escritura y lectura
    Given path '/store/order'
    And def postRequestIdload = read('../data/resp/postId.json')
    And def postRequestOrderload = read('../data/resp/postRequestOrderload.json')
    #And remove postRequestOrderload.id
    And set postRequestOrderload.id = postRequestIdload
    And request postRequestOrderload
    And header Accept = '*/*'
    And header Content-Type = 'application/json'
    When method POST
    And eval java.lang.Thread.sleep(5000)
    Then status 200
    And match response.petId == '#number'




  @consultarv
  Scenario: consultar order pet
    And def postRequestIdread = read('../data/resp/postId.json')
    And def orderId = postRequestIdread
    And print 'Order ID a consultar:', orderId
    Given path '/store/order', orderId
    When method GET
    And eval java.lang.Thread.sleep(5000)
    Then status 200
    And match response.id == orderId
    And match response contains{id: '#number',petId: '#number',quantity: '#number',status: '#string',complete: '#boolean'}

  @eliminarv
  Scenario: Eliminar el pedido creado
    And def postRequestIdread = read('../data/resp/postId.json')
    And def orderId = postRequestIdread
    And print 'Order ID a consultar:', orderId
    Given path '/store/order', orderId
    When method DELETE
    And eval java.lang.Thread.sleep(5000)
    Then status 200
    And match response contains { code: 200, type: 'unknown', message: '#string' }


  @ReConsultav
  Scenario: ReConsulta de eliminacion
    And def postRequestIdread = read('../data/resp/postId.json')
    And def orderId = postRequestIdread
    And print 'Order ID a consultar:', orderId
    Given path '/store/order', orderId
    When method GET
    And eval java.lang.Thread.sleep(5000)
    Then status 404
