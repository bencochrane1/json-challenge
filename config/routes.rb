Rails.application.routes.draw do

  root 'feeds#index'

  get '/', to: 'feeds#index'

end
