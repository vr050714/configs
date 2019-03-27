function set_color_theme
Themes = get_all_themes;
[ID, isOK] = listdlg('ListString', {Themes.Name},...
                     'SelectionMode', 'single',...
                     'Name', 'Themes',...
                     'PromptString', 'Select color theme');
if isOK
    set_color_prefs(Themes(ID).Settings);
end


function Themes = get_all_themes
Data = {
    'Zenburn', ...
    {
        'ColorsText' [220, 220, 204]
        'ColorsBackground' [63, 63, 63]
        'Colors_M_Keywords' [240, 223, 175]
        'Colors_M_Comments' [127, 159, 127]
        'Colors_M_Strings' [204, 147, 147]
        'Colors_M_UnterminatedStrings' [223, 190, 149]
        'Colors_M_SystemCommands' [202, 230, 130]
        'Color_CmdWinErrors' [128, 212, 170]
        'Color_CmdWinWarnings' [255, 255, 255]
        'Colors_HTML_HTMLLinks' [147, 147, 204]
        'Colors_M_Warnings' [204, 147, 147]
        'Editor.VariableHighlighting.Color' [80, 80, 80]
        'Editor.NonlocalVariableHighlighting.TextColor' [138, 204, 207]
        'Editorhighlight-lines' [80, 80, 80]
        'ColorsUseSystem' false
        'ColorsUseMLintAutoFixBackground' false
        'Editor.VariableHighlighting.Automatic' true
        'Editor.NonlocalVariableHighlighting' true
        'EditorCodepadHighVisible' false
        'EditorCodeBlockDividers' true
    }; ...
    'Dracula', ...
    {
        'ColorsText' [169, 183, 198]
        'ColorsBackground' [43, 43, 43]
        'Colors_M_Keywords' [204, 120, 50]
        'Colors_M_Comments' [128, 128, 128]
        'Colors_M_Strings' [106, 135, 89]
        'Colors_M_UnterminatedStrings' [106, 135, 89]
        'Colors_M_SystemCommands' [187, 181, 41]
        'Color_CmdWinErrors' [204, 51, 0]
        'Color_CmdWinWarnings' [255, 100, 0]
        'Colors_HTML_HTMLLinks' [86, 111, 163]
        'Colors_M_Warnings' [255, 148, 0]
        'Editor.VariableHighlighting.Color' [80, 80, 80]
        'Editor.NonlocalVariableHighlighting.TextColor' [0, 163, 163]
        'Editorhighlight-lines' [255, 242, 221]
        'ColorsUseSystem' false
        'ColorsUseMLintAutoFixBackground' false
        'Editor.VariableHighlighting.Automatic' true
        'Editor.NonlocalVariableHighlighting' true
        'EditorCodepadHighVisible' false
        'EditorCodeBlockDividers' true
    }; ...
    'Solarized Light', ...
    {
        'ColorsText'         '657A81'
        'ColorsBackground'   'FDF6E3'
        'Colors_M_Keywords'  'B58900'
        'Colors_M_Comments'  '93A1A1'
        'Colors_M_Strings'   '2AA198'
        'Colors_M_UnterminatedStrings' '586E75'
        'Colors_M_SystemCommands' [181 137 0]
        'Color_CmdWinErrors' [220  50  47]
        'Color_CmdWinWarnings' [203  75  22]
        'Colors_HTML_HTMLLinks' [38 139 210]
        'Colors_M_Warnings' [203  75  22]
        'Editor.VariableHighlighting.Color' [238 232 213]
        'Editor.NonlocalVariableHighlighting.TextColor' [42 161 152] % [108 113 196]
        'Editorhighlight-lines' [238 232 213]
        'ColorsUseSystem' false
        'ColorsUseMLintAutoFixBackground' false
        'Editor.VariableHighlighting.Automatic' true
        'Editor.NonlocalVariableHighlighting' true
        'EditorCodepadHighVisible' false
        'EditorCodeBlockDividers' true
    }; ...
    'Solarized Dark', ...
    {
        'ColorsText'         '839496'
        'ColorsBackground'   '002B36'
        'Colors_M_Keywords'  'B58900'
        'Colors_M_Comments'  '93A1A1'
        'Colors_M_Strings'   '2AA198'
        'Colors_M_UnterminatedStrings' '586E75'
        'Colors_M_SystemCommands' [181 137 0]
        'Color_CmdWinErrors' [220  50  47]
        'Color_CmdWinWarnings' [203  75  22]
        'Colors_HTML_HTMLLinks' [38 139 210]
        'Colors_M_Warnings' [203  75  22]
        'Editor.VariableHighlighting.Color' [7 54 66]
        'Editor.NonlocalVariableHighlighting.TextColor' [42 161 152] % [108 113 196]
        'Editorhighlight-lines' [238 232 213]
        'ColorsUseSystem' false
        'ColorsUseMLintAutoFixBackground' false
        'Editor.VariableHighlighting.Automatic' true
        'Editor.NonlocalVariableHighlighting' true
        'EditorCodepadHighVisible' false
        'EditorCodeBlockDividers' true
    }
    };
Themes = struct('Name',Data(:,1),'Settings',Data(:,2));


function set_color_prefs(Settings)
for n = 1:size(Settings,1)
    key = Settings{n,1};
    val = Settings{n,2};
    if (isa(val,'double') || isa(val,'logical')) && length(val) == 1
        com.mathworks.services.Prefs.setBooleanPref(key, val>0);
    elseif isa(val,'double') && length(val) == 3 || isa(val,'char') && length(val) == 6
        if isa(val,'char')
            val = hexcolor(val);
        end
        com.mathworks.services.Prefs.setColorPref(key, java.awt.Color(val(1)/255, val(2)/255, val(3)/255));
        com.mathworks.services.ColorPrefs.notifyColorListeners(key)
    else
        warning('wrong format: key = %s, type = %s, length = %d', key, class(val), length(val));
    end
end
com.mathworks.services.Prefs.save;


function c = hexcolor(s)
c = [hex2dec(s(1:2)), hex2dec(s(3:4)), hex2dec(s(5:6))];
