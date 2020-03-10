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

SolarizedCommon = {
    'Colors_M_Keywords'  'B58900'
    'Colors_M_Comments'  '2AA198'
    'Colors_M_Strings'   'D33682'
    'Colors_M_UnterminatedStrings' '586E75'
    'Colors_M_SystemCommands'  '859900'
    'Color_CmdWinErrors'       'DC322F'
    'Color_CmdWinWarnings'     'CB4B16'
    'Colors_HTML_HTMLLinks'    '268BD2'
    'Colors_M_Warnings'        'CB4B16'
    'Editor.VariableHighlighting.Color' 'EEE8D5'
    'Editor.NonlocalVariableHighlighting.TextColor'  '268BD2'
    'Editorhighlight-lines'  '859900'
    'ColorsUseSystem' false
    'ColorsUseMLintAutoFixBackground' false
    'Editor.VariableHighlighting.Automatic' true
    'Editor.NonlocalVariableHighlighting' true
    'EditorCodepadHighVisible' false
    'EditorCodeBlockDividers' true
};

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
    'JetBrains Darcula', ...
    {
        'ColorsText' [169, 183, 198]
        'ColorsBackground' [43, 43, 43]
        'Colors_M_Keywords' [204, 120, 50]
        'Colors_M_Comments' [128, 128, 128]
        'Colors_M_Strings' [106, 135, 89]
        'Colors_M_UnterminatedStrings' [106, 135, 89]
        'Colors_M_SystemCommands' [187, 181, 41]
        'Color_CmdWinErrors' [214, 102, 77]
        'Color_CmdWinWarnings' [255, 177, 127]
        'Colors_HTML_HTMLLinks' [141, 171, 229]
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
    [
        {
            'ColorsText'         '657B83'
            'ColorsBackground'   'FDF6E3'
        }
        SolarizedCommon
    ]; ...
    'Solarized Dark', ...
    [
        {
            'ColorsText'         '839496'
            'ColorsBackground'   '002B36'
        }
        SolarizedCommon
    ]
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
