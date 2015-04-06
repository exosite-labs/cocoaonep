debug('Starting')

local rate = alias['rate']
local waitforit = alias['waitforit']

rate.value = 25
local sleeper = 25
local counter = 0

while true do
    debug('sleeping for ' .. sleeper)
    local ts = rate.wait(now + sleeper)
    debug('awake!')
    sleeper = rate.value
    waitforit.value = counter
    counter = counter + 1
end
