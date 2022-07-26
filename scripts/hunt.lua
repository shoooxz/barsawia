hunt = hunt or {}

function hunt:escape_arrows(direction)
    if direction == "polnocny-wschod" then
        cecho("\n\n<red>        # # # ")
        cecho("\n<red>          # #   ")
        cecho("\n<red>        #   #   ")
        cecho("\n<red>      #       \n")
    elseif direction == "polnocny-zachod" then
        cecho("\n\n<red>     # # #   ")
        cecho("\n<red>     # #       ")
        cecho("\n<red>     #   #     ")
        cecho("\n<red>           # \n")
    elseif direction == "polnoc" then
        cecho("\n\n<red>        #       ")
        cecho("\n<red>       ###        ")
        cecho("\n<red>      # # #       ")
        cecho("\n<red>        #         ")
        cecho("\n<red>        #       \n")
    elseif direction == "poludnie" then
        cecho("\n\n<red>        #       ")
        cecho("\n<red>        #         ")
        cecho("\n<red>      # # #       ")
        cecho("\n<red>       ###        ")
        cecho("\n<red>        #       \n")
    elseif direction == "poludniowy-wschod" then
        cecho("\n\n<red>      #       ")
        cecho("\n<red>        #   #   ")
        cecho("\n<red>          # #   ")
        cecho("\n<red>        # # # \n")
    elseif direction == "poludniowy-zachod" then
        cecho("\n\n<red>           #")
        cecho("\n<red>     #   #   ")
        cecho("\n<red>     # #     ")
        cecho("\n<red>     # # # \n")
    elseif direction == "wschod" then
        cecho("\n\n<red>            #   ")
        cecho("\n<red>             #  ")
        cecho("\n<red>    # # # # # # ")
        cecho("\n<red>             #  ")
        cecho("\n<red>            #   \n")
    elseif direction == "zachod" then
        cecho("\n\n<red>    #         ")
        cecho("\n<red>   #          ")
        cecho("\n<red>  # # # # # # ")
        cecho("\n<red>   #          ")
        cecho("\n<red>    #         \n")
    elseif direction == "gora" then
        cecho("\n\n<red>     #     #   ")
        cecho("\n<red>     #     #   ")
        cecho("\n<red>     #     #   ")
        cecho("\n<red>     #     #   ")
        cecho("\n<red>      # # # \n")
    elseif direction == "dol" then
        cecho("\n\n<red>     # # # #")
        cecho("\n<red>     #      #   ")
        cecho("\n<red>     #       #   ")
        cecho("\n<red>     #      #   ")
        cecho("\n<red>     # # # #  \n")
    end
end
