require "spec_helper"

describe Hydramata::GroupsController do
  describe "routing" do
    it "routes to #index" do
      route = ["hydramata/groups#index"]
      expect(get("/groups")).to route_to(*route)
      expect(get: hydramata_groups_path).to route_to(*route)
    end

    it "routes to #new" do
      route = ["hydramata/groups#new"]
      expect(get("/groups/new")).to route_to(*route)
      expect(get: new_hydramata_group_path).to route_to(*route)
    end

    it "routes to #show" do
      route = ["hydramata/groups#show", :id => "1"]
      expect(get("/groups/1")).to route_to(*route)
      expect(get: hydramata_group_path("1")).to route_to(*route)
    end

    it "routes to #edit" do
      route = ["hydramata/groups#edit", :id => "1"]
      expect(get("/groups/1/edit")).to route_to(*route)
      expect(get: edit_hydramata_group_path("1")).to route_to(*route)
    end

    it "routes to #create" do
      route = ["hydramata/groups#create"]
      expect(post("/groups")).to route_to(*route)
      expect(post: hydramata_groups_path).to route_to(*route)
    end

    it "routes to #update" do
      route = ["hydramata/groups#update", :id => "1"]
      expect(put("/groups/1")).to route_to(*route)
      expect(put: hydramata_group_path("1")).to route_to(*route)
    end

    it "routes to #destroy" do
      route = ["hydramata/groups#destroy", :id => "1"]
      expect(delete("/groups/1")).to route_to(*route)
      expect(delete: hydramata_group_path("1")).to route_to(*route)
    end

  end
end
