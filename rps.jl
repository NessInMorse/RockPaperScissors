using Random
using Printf
using Plots


function rps(n::Int64, output::Vector{String}, outcomes::Vector{String}, indices::Vector{Vector{String}})
        player1::Int8 = 0
        player2::Int8 = 0
        options::Int8 = 3
        offset::Int8 = 1
        minimum_value::Int8 = 0
        maximum_value::Int8 = 2
        for i in 1:n
                player1 = rand(minimum_value:maximum_value)
                player2 = rand(minimum_value:maximum_value)
                output[i] = outcomes[(((player1 - player2) + options) % options) + offset]
        end
end

function rps_semicolon(n::Int64, output::Vector{String}, outcomes::Vector{String}, indices::Vector{Vector{String}})
        player1::Int8 = 0;
        player2::Int8 = 0;
        options::Int8 = 3;
        offset::Int8 = 1;
        minimum_value::Int8 = 0;
        maximum_value::Int8 = 2;
        for i in 1:n
                player1 = rand(minimum_value:maximum_value);
                player2 = rand(minimum_value:maximum_value);
                output[i] = outcomes[(((player1 - player2) + options) % options) + offset];
        end
end

function rps_dynamic(n, output, outcomes, indices)
        player1 = 0
        player2 = 0
        options = 3
        offset = 1
        minimum_value = 0
        maximum_value = 2
        for i in 1:n
                player1 = rand(minimum_value:maximum_value)
                player2 = rand(minimum_value:maximum_value)
                output[i] = outcomes[(((player1 - player2) + options) % options) + offset]
        end
end


function rps_indices(n::Int64, output::Vector{String}, outcomes::Vector{String}, indices::Vector{Vector{String}})
        player1::Int8 = 0
        player2::Int8 = 0
        minimum_value::Int8 = 1
        maximum_value::Int8 = 3
        for i in 1:n
                player1 = rand(minimum_value:maximum_value)
                player2 = rand(minimum_value:maximum_value)
                output[i] = indices[player1][player2]
        end
end


function rps_if_statement(n::Int64, output::Vector{String}, options::Vector{String}, indices::Vector{Vector{String}})
        player1::Int8 = 0
        player2::Int8 = 0
        minimum_value::Int8 = 0
        maximum_value::Int8 = 2
        # println(length(output))
        for i in 1:n
                player1 = rand(minimum_value:maximum_value)
                player2 = rand(minimum_value:maximum_value)
                if player1 == player2
                        output[i] = options[1]
                elseif player1 == 0 && player2 == 2 || player1 == 1 && player2 == 0 || player1 == 2 && player2 == 1
                        output[i] = options[1]
                else
                        output[i] = options[2]
                end
        end
        #println(output)
end

function rps_if_statement_bad(n::Int64, output::Vector{String}, options::Vector{String}, indices::Vector{Vector{String}})
        player1::Int8 = 0
        player2::Int8 = 0
        minimum_value::Int8 = 0
        maximum_value::Int8 = 2
        # println(length(output))
        for i in 1:n
                player1 = rand(minimum_value:maximum_value)
                player2 = rand(minimum_value:maximum_value)
                if player1 == player2
                        output[i] = options[1]
                elseif player1 == 0 && player2 == 2
                        output[i] = options[1]
                elseif  player1 == 1 && player2 == 0
                        output[i] = options[1]
                elseif  player1 == 2 && player2 == 1
                        output[i] = options[1]
                else
                        output[i] = options[2]
                end
        end
        #println(output)
end




function rps_dict(n::Int64)
        """
        Gebruik dictionaries alleen om static dingen te maken, niet om telkens opnieuw te maken
        """
        output = ["" for i in 1:n]
        options = ["Draw", "Player 1 wins", "Player 2 wins"]
        player1::Int8 = 0
        player2::Int8 = 0
        minimum_value::Int8 = 0
        maximum_value::Int8 = 2

        for i in 1:n

                player1 = rand(minimum_value:maximum_value)
                player2 = rand(minimum_value:maximum_value)
                if player1 == player2
                        output[i] = options[1]
                else
                        dic::Dict = Dict{Int8, String}(player1 => options[2], player2 => options[3])
                        lijst = sort([player1, player2])
                        output[i] = dic[lijst[(sum(lijst) % 2) + 1]]
                end
        end
end

function time_functions()
        max_n::Int64 = 5000000
        stepcalc::Float64 = max_n*.01
        range_max = range(1, max_n, step=stepcalc)
        fill = ""
        fillList = [fill for i in 1:max_n]
        outcomes = ["Draw", "Player 1 wins", "Player 2 wins"]
        indices = [["Draw", "Player 2 wins", "Player 1 wins"], ["Player 1 wins", "Draw", "Player 2 wins"], ["Player 2 wins", "Player 1 wins", "Draw"]]
        test_functions = [rps, rps_semicolon, rps_dynamic, rps_indices, rps_if_statement]
        timesList = [[@elapsed test_functions[j](Integer(i), fillList, outcomes, indices)
                        for i in range_max]
                        for j in 1:length(test_functions)]
        # println(timesList)
        return timesList, ["x:int y:int ans[(x+y)%3]" "ans[(x+y)%3];" "ans[(x+y)%3]" "ans[x][y]" "if-statements"]
end
data, labels = time_functions()
println(labels)


plot(
    data,
    label = labels,
    title = "Testing Rock Paper Scissor Algorithms",
    xlabel = "Iterations (*50,000)",
    ylabel = "Time elapsed",
    show = true
)
println("Goed bezig!")
while true
        sleep(30)
end