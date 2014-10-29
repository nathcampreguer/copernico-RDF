# -*- encoding : utf-8 -*-
class MetadataRecordRdf
  include Tripod::Resource

  rdf_type 'http://def.seegrid.csiro.au/static/isotc211/iso19115/2003/metadata'
  graph_uri 'http://def.seegrid.csiro.au/static/isotc211/iso19115/2003/metadata'

  # field :identification, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#Identification'
  # field :metametadata, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#Metadata'
  # field :quality, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/dataquality#DataQuality'
  # field :points_of_contact, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#pointOfContact', multivalued: true
  # field :authors, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#contact', multivalued: true

  #contact
  field :name, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#individualName'
  field :organization, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#organisationName'
  field :role, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#positionName'
  field :address, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#deliveryPoint'
  field :city, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#city'
  field :country, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#country'
  field :zipcode, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#postalCode'
  field :phone, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#phone'
  field :email, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#electronicMailAddress'

  # identification
  field :title, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#title'
  field :abstract, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#abstract'
  field :keywords, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#Keywords', multivalued: true
  field :status, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#status'
  field :credits, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#credit', multivalued: true
  field :dates, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#date', multivalued: true

  #metametadata
  field :uuid, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#fileIdentifier'
  field :standard_name, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#metadataStandardName'
  field :standard_version, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#metadataStandardVersion'
  field :character_sets, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/code/CharacterSet', multivalued: true
  field :languages, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#language', multivalued: true

  #quality
  field :scope, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/dataquality#scope'
  field :statement, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/lineage#statement'
  field :maintainance, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/code/MaintenanceFrequency/'
end
