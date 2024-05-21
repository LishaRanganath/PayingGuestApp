module PaymentsManager
    class PdfGenerator
        require 'prawn'
        include Prawn::Tables
        include Prawn::View
    
        def initialize(booking)
            @booking = booking
        end
    
        def generate
            Prawn::Document.new do |pdf|
                pdf.text "Invoice for Booking ##{@booking.id}", size: 30, style: :bold
                pdf.move_down 20
                generate_table(pdf)
            end.render
        end
    
        private
    
        def generate_table(pdf)
            pdf.table(table_data) do
                row(0).font_style = :bold
                columns(1..3).align = :right
                self.header = true
                self.row_colors = ['DDDDDD', 'FFFFFF']
            end
        end
    
        def table_data
            [
                ["Item", "Quantity", "Unit Price", "Total Price"],
                # ["Room Charge", @booking.room_quantity, price(@booking.room_price), price(@booking.room_total)],
                # ["Service Charge", @booking.service_quantity, price(@booking.service_price), price(@booking.service_total)],
                # # Add more rows as needed
                ["", "", "Total", price(@booking.total_price)]
            ]
        end
    
        def price(amount)
        sprintf("$%.2f", amount)
        end
    end
end