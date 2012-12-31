class ChangeCompanyIdInAgentInvoices < ActiveRecord::Migration
  def change
    rename_column :agent_invoices, :agent_id, :company_id
  end
end
