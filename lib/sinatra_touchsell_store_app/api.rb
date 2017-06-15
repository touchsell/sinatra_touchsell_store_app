require "stringio"
require "pathname"
require 'ostruct'
require 'rest-client'
require 'json'

class TSAPI
  def initialize(base_url, token)
    @base_url = base_url
    @token = token
  end

  def get url, params={}
    params[:access_token] = @token
    #puts "get: #{@base_url}#{url} with params #{params}"
    RestClient.get "#{@base_url}#{url}", {
      params: params,
    }
  end

  def put url, params = {}
    params[:access_token] = @token
    RestClient.put "#{@base_url}#{url}", params, {
    }
  end

  def post url, params = {}
    params[:access_token] = @token
    RestClient.post "#{@base_url}#{url}", params, {
      "Content-Type": "application/json",
      Accept: :json
    }
  end

  def parse(response)
    JSON.parse(response, object_class: OpenStruct)
  end

  def current_user
    parse( get("me") )
  end

  def get_clients(params={})
    parse( get("/clients", params) )
  end

  def get_kpi(params={})
    parse( get("/stats/kpi", params) )
  end

  def get_nodes(params={})
    parse( get("/nodes", params) )
  end

  def get_medias(params={})
    parse( get("/medias", params) )
  end

  def get_form_submits(id)
    parse( get("/forms/#{id}/submits"))
  end

  def get_clients(params={})
    parse( get("/clients", params))
  end
end
