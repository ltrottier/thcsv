local M = {}

function M.read(csvFile, separator, skipFirst)
  local separator = separator or ','
  local skipFirst = skipFirst or false
  local fid = io.open(csvFile, 'rb')
  if not fid then error(('Incorrect filename "%s"'):format(csvFile)) end
  local str = fid:read("*all")
  fid:close()
  local splits = str:split('\n')
  local i0 = skipFirst and 1 or 0
  local nRows = #splits - i0
  local nCols = #splits[i0+1]:split(separator)
  local output = torch.Tensor(nRows, nCols)
  for i = 1, nRows do
    output[i]:copy(torch.Tensor(splits[i + i0]:split(separator)))
  end
  return output
end

function M.write(csvFile, tensor, header)
  if tensor:nDimension() ~= 2 then
    error('Input tensor should have size "nRows x nCols"')
  end
  fid = io.open(csvFile, 'wb')
  if not fid then error(('Incorrect filename "%s"'):format(csvFile)) end
  if header then
    for i = 1,#header do
      fid:write(header[i])
      if i < #header then
        fid:write(', ')
      end
    end
    fid:write('\n')
  end
  for i = 1,tensor:size(1) do
    for j = 1,tensor:size(2) do
      fid:write(tensor[i][j])
      if j < tensor:size(2) then
        fid:write(', ')
      end
    end
    fid:write('\n')
  end
  fid:flush()
  fid:close()
end

return M
