class Application
  @@items = []

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new

    if req.path.match(/items/)
      item_name = req.path.split('/').last
      item = @@items.find { |i| i.name == item_name }
      if item
        res.write item.price
      else
        res.status = 400
        res.write "Item not found"
      end
    else
      res.status = 404
      res.write "Route not found"
    end

    res.finish
  end
end
