module Types
  class MutationType < Types::Model::BaseObject
    field :create_category, mutation: Mutations::Category::CreateCategory
    field :update_category, mutation: Mutations::Category::UpdateCategory
    field :delete_category, mutation: Mutations::Category::DeleteCategory

    field :create_item, mutation: Mutations::Item::CreateItem
    field :delete_item, mutation: Mutations::Item::DeleteItem
    field :update_item, mutation: Mutations::Item::UpdateItem

    field :create_customer, mutation: Mutations::Customer::CreateCustomer
    field :update_customer, mutation: Mutations::Customer::UpdateCustomer
    field :delete_customer, mutation: Mutations::Customer::DeleteCustomer

    field :create_service_order, mutation: Mutations::ServiceOrder::CreateServiceOrder

    field :create_user, mutation: Mutations::User::CreateUser
    field :sign_in, mutation: Mutations::User::SignIn
  end
end
