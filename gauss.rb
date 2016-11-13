require 'sinatra'
require 'rubystats'
require 'chartkick'
require 'pp'

gen = Rubystats::NormalDistribution.new(0, 100)
gen.rng               # a single random sample

get '/' do
    @data = gen.rng((params['c'] || 100).to_i).map{|x| x.to_i}
    @data = @data.group_by {|x| x / (params['g'] || 10).to_i }.map{|k,a| [k, a.length]}
    pp @data
    @chart = scatter_chart @data
    @ops = [{count:10, g_size:10},
    {count:100, g_size:10},
    {count:1000, g_size:10},
    {count:1000, g_size:5},
    {count:10000, g_size:20},
    {count:10000, g_size:1}]
    erb :index
end
