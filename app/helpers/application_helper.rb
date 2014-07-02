module ApplicationHelper
  def geonetwork_providers
    MetadataRecordsController::PROVIDERS
  end

  def geonetwork_default_provider
    MetadataRecordsController::DEFAULT_PROVIDER
  end
end
