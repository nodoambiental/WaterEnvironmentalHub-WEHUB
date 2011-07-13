class ApiController < ApplicationController

  respond_to :json, :xml
  
  def feature_types
    @feature_types = FeatureType.all
    
    respond_with(@feature_types, :dasherize => false)
  end
  
  def datasets
    feature_type_id = params[:feature_type_id]
    
    if feature_type_id
      @datasets = Dataset.where(:feature_type_id => feature_type_id).limit(20)
    end  
    
    respond_with(@datasets)
  end
  
  def dataset
    dataset_id = params[:id]

    if dataset_id
      @dataset = Dataset.find_by_uuid(dataset_id)
    end

    respond_with(@dataset)
  end
  
  def feature
    if params[:id] && params[:output]
      dataset = Dataset.find_by_uuid(params[:id])
      if dataset && dataset.feature
        feature_format_factory = FeatureFormatFactory.new
        feature = feature_format_factory.find(params[:output], dataset.feature)
        if feature
          @data = feature[:data]
        end
      end
    end
    
    # returns results in text format b/c some of our data results in invalid XML and JSON
    render :text => @data
  end
  
end