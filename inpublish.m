function stat = inpublish()
% INPUBLISH  Return true the current function is called via publish

  stack = dbstack;
  stat = false;
  for i = 1:numel(stack)
    if strcmp(stack(i).name, 'publish')
      stat = true;
      break
    end
  end
  return
end
