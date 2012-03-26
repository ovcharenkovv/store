# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base
  default :from     => 'PoshStore <no-reply@poshstore.com.ua>',
          :reply_to => 'poshstoreua@gmail.com'

  def order_received(order)
    @order = order
    mail :to => @order.email, :subject => 'Заказ на Posh Store'
  end

  def order_send(order)
    @order = order
    mail :to => 'lavrovanna@yandex.ru',:cc=>'ovcharenkovv@gmail.com', :subject => 'Заказ на Posh Store'
  end

  def order_dealer_send(order)
    @order = order
    mail :to => 'lavrovanna@yandex.ru',:cc=>['marastudio@mail.ru','ovcharenkovv@gmail.com'], :subject => 'Заказ на Posh Store'
  end

  def order_shipped(order)
    @order = order
    mail :to => order.email, :subject => 'Заказ на Posh Store'
  end

  def order_status_change(order)
    @order = order
    mail :to => @order.email, :subject => 'Статус Вашего заказа'
  end

end
