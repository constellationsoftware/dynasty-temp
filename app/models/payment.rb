## Before working with this sample code, please be sure to read the accompanying Readme.txt file.
## It contains important information regarding the appropriate use of and conditions for this sample
## code. Also, please pay particular attention to the comments included in each individual code file,
## as they will assist you in the unique and correct implementation of this code on your specific platform.
## Copyright 2008 Authorize.Net Corp.
#
#require 'net/http'
#require 'net/https'
#require 'uri'
#require 'rexml/document'
#
## Use this for testing: https://apitest.authorize.net/xml/v1/request.api
## Use this for real transactions: https://api.authorize.net/xml/v1/request.api
#$uri= URI.parse('https://apitest.authorize.net/xml/v1/request.api')
#$apilogin = 'todo' # put your api user login here
#$apikey = 'todo' # put your transaction key here
#
#$xmlCreateProfile = <<EOF
#<?xml version="1.0"?>
#<createCustomerProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
#  <merchantAuthentication>
#    <name>@login@</name>
#    <transactionKey>@key@</transactionKey>
#  </merchantAuthentication>
#  <profile>
#    <merchantCustomerId>mycustId123</merchantCustomerId>
#    <description>some description</description>
#    <email>@email@</email>
#  </profile>
#</createCustomerProfileRequest>
#EOF
#
#$xmlCreatePaymentProfile = <<EOF
#<?xml version="1.0"?>
#<createCustomerPaymentProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
#  <merchantAuthentication>
#    <name>@login@</name>
#    <transactionKey>@key@</transactionKey>
#  </merchantAuthentication>
#  <customerProfileId>@profileId@</customerProfileId>
#  <paymentProfile>
#    <billTo>
#      <firstName>John</firstName>
#      <lastName>Doe</lastName>
#      <company></company>
#      <address>123 Main St.</address>
#      <city>Bellevue</city>
#      <state>WA</state>
#      <zip>98004</zip>
#      <country>USA</country>
#      <phoneNumber>000-000-0000</phoneNumber>
#      <faxNumber></faxNumber>
#    </billTo>
#    <payment>
#      <creditCard>
#        <cardNumber>4111111111111111</cardNumber>
#        <expirationDate>2023-12</expirationDate>
#      </creditCard>
#    </payment>
#  </paymentProfile>
#  <validationMode>liveMode</validationMode>
#</createCustomerPaymentProfileRequest>
#EOF
#
#$xmlCreateTransaction = <<EOF
#<?xml version="1.0"?>
#<createCustomerProfileTransactionRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
#  <merchantAuthentication>
#    <name>@login@</name>
#    <transactionKey>@key@</transactionKey>
#  </merchantAuthentication>
#  <transaction>
#    <profileTransAuthCapture>
#      <amount>@amount@</amount>
#      <tax>
#        <amount>1.00</amount>
#        <name>WA state sales tax</name>
#        <description>Washington state sales tax</description>
#      </tax>
#      <shipping>
#        <amount>2.00</amount>
#        <name>ground based shipping</name>
#        <description>Ground based 5 to 10 day shipping</description>
#      </shipping>
#      <lineItems>
#        <itemId>ITEM00001</itemId>
#        <name>name of item sold</name>
#        <description>Description of item sold</description>
#        <quantity>1</quantity>
#        <unitPrice>6.95</unitPrice>
#        <taxable>true</taxable>
#      </lineItems>
#      <lineItems>
#        <itemId>ITEM00002</itemId>
#        <name>name of other item sold</name>
#        <description>Description of other item sold</description>
#        <quantity>1</quantity>
#        <unitPrice>1.00</unitPrice>
#        <taxable>true</taxable>
#      </lineItems>
#      <customerProfileId>@profileId@</customerProfileId>
#      <customerPaymentProfileId>@paymentProfileId@</customerPaymentProfileId>
#      <!--<customerShippingAddressId></customerShippingAddressId>-->
#      <order>
#        <invoiceNumber>@invoice@</invoiceNumber>
#        <description>description of transaction</description>
#        <purchaseOrderNumber>PONUM000001</purchaseOrderNumber>
#      </order>
#      <taxExempt>false</taxExempt>
#      <recurringBilling>false</recurringBilling>
#      <cardCode>000</cardCode>
#    </profileTransAuthCapture>
#  </transaction>
#</createCustomerProfileTransactionRequest>
#EOF
#
#$xmlDeleteProfile = <<EOF
#<?xml version="1.0"?>
#<deleteCustomerProfileRequest xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
#  <merchantAuthentication>
#    <name>@login@</name>
#    <transactionKey>@key@</transactionKey>
#  </merchantAuthentication>
#  <customerProfileId>@profileId@</customerProfileId>
#</deleteCustomerProfileRequest>
#EOF
#
#def CreateProfile(email) # returns profileId
#  profileId = ''
#  puts
#  puts '---------------------'
#  puts 'Creating Customer Profile with email = ' + email + ' ...'
#  xml = SetApiAuthentication($xmlCreateProfile)
#  xml = xml.sub('@email@', email) # todo: user input should always be checked for malicious data.
#  doc = SendXml(xml)
#  success = IsSuccess(doc)
#  if !success
#    PrintErrors(doc)
#  else
#    profileId = REXML::XPath.first(doc.root, '/*/customerProfileId').text
#    puts
#    puts 'New customerProfileId = ' + profileId
#  end
#  return profileId
#end
#def CreatePaymentProfile(profileId) # returns paymentProfileId
#  paymentProfileId = ''
#  puts
#  puts '---------------------'
#  puts 'Creating Customer Payment Profile ...'
#  xml = SetApiAuthentication($xmlCreatePaymentProfile)
#  xml = xml.sub('@profileId@', profileId)
#  doc = SendXml(xml)
#  success = IsSuccess(doc)
#  if !success
#    PrintErrors(doc)
#  else
#    paymentProfileId = REXML::XPath.first(doc.root, '/*/customerPaymentProfileId').text
#    puts
#    puts 'New customerPaymentProfileId = ' + paymentProfileId
#  end
#  return paymentProfileId
#end
#def CreateTransaction(profileId, paymentProfileId, amount) # returns transId
#  transId = ''
#  puts
#  puts '---------------------'
#  puts 'Creating Transaction for $' + amount +  ' ...'
#  xml = SetApiAuthentication($xmlCreateTransaction)
#  xml = xml.sub('@profileId@', profileId)
#  xml = xml.sub('@paymentProfileId@', paymentProfileId)
#  xml = xml.sub('@amount@', amount)
#  xml = xml.sub('@invoice@', 'inv'+rand(100000).to_s)
#  doc = SendXml(xml)
#  success = IsSuccess(doc)
#  if !success
#    PrintErrors(doc)
#  end
#  directResponse = REXML::XPath.first(doc.root, '/*/directResponse').text
#  transId = directResponse.split(',')[6]
#  puts
#  puts 'New transId = ' + transId
#  return transId
#end
#def DeleteProfile(profileId)
#  puts
#  puts '---------------------'
#  puts 'Deleting Profile ' + profileId + ' ...'
#  xml = SetApiAuthentication($xmlDeleteProfile)
#  xml = xml.sub('@profileId@', profileId)
#  doc = SendXml(xml)
#  success = IsSuccess(doc)
#  if !success
#    PrintErrors(doc)
#  else
#    puts
#    puts 'Successfully deleted profile.'
#  end
#end
#def SetApiAuthentication(xml)
#  xml = xml.sub('@login@', $apilogin)
#  xml = xml.sub('@key@', $apikey)
#  return xml
#end
#def SendXml(xml) # returns xmlDoc of response
#  puts
#  puts $uri
#  puts
#  puts xml
#  http = Net::HTTP.new($uri.host, $uri.port)
#  http.use_ssl = 443 == $uri.port
#  resp, body = http.post($uri.path, xml, {'Content-Type' => 'text/xml'})
#  puts
#  puts resp
#  puts
#  puts body
#  return REXML::Document.new(body)
#end
#def PrintErrors(docResponse)
#  REXML::XPath.each(docResponse.root, '/*/messages/message') { | m |
#    puts
#    puts 'Error: [' + REXML::XPath.first(m, 'code').text + '] ' + REXML::XPath.first(m, 'text').text
#  }
#end
#def IsSuccess(docResponse)
#  return "Ok" == REXML::XPath.first(docResponse.root, '/*/messages/resultCode').text
#end
#
#profileId = CreateProfile('email' + rand(100000).to_s + '@example.com')
#paymentProfileId = CreatePaymentProfile(profileId)
#transId = CreateTransaction(profileId, paymentProfileId, '10.95')
#DeleteProfile(profileId)
