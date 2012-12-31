class ChangeCompanyIdInPayAgents < ActiveRecord::Migration
  def change
    rename_column :pay_agents, :agent_id, :company_id
  end
end
