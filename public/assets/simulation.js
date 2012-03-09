$(document).ready(function()
{
   $('#next_week').click(function() {
      goto_week( current_week + 1 );
      return false;
    });

    $('#previous_week').click(function() {
       goto_week( current_week - 1 );
       return false;
    });

    $('#reset_week').click(function() {
      $.get('/banking/goto_week/0', function(data) {});
      return false;
    });

    $('#sync_week').click(function() {
      sync();
       return false;
    });
    
    function goto_week(week)
    {
      $.ajax({
        url: '/banking/goto_week/' + week,
        cache: false,
        dataType: 'text',
        success: function(data){}
      });
    }
    
    function tested_sync()
    {
      $.get('/banking/counter', function(data) {
        if ( current_week != data)
        {
          current_week = data;
          $('#season_week').text('' + current_week);
          
          if ( team_id > 0 )
          {
            get_team_balance();
            get_team_ledger();
          }
          else if ( team_id < 0 )
          {
            get_teams_balance_table();
            get_teams_balance_total();
            get_league_balance();
          }
          else
          {
            get_dynasty_dollars();
            get_activity_table();
            get_balance_table();
          }
        }  
      });
    }
    
    function sync()
    {
      $.get('/banking/counter', function(data) {
        current_week = data;
        $('#season_week').text('' + current_week);
      });

      if ( team_id > 0 )
      {
        get_team_balance();
        get_team_ledger();
      }
      else if ( team_id < 0 )
      {
        get_teams_balance_table();
        get_teams_balance_total();
        get_league_balance();
      }
      else
      {
        get_dynasty_dollars();
        get_activity_table();
        get_balance_table();
      }
    }
    
    function get_activity_table()
    {
      $.ajax({
        url: '/banking/activity_table',
        cache: false,
        dataType: 'html',
        success: function(data){
          $('#activity_table').replaceWith(data);
        }
      });
    }
    
    function get_balance_table()
    {
      $.ajax({
        url: '/banking/balance_table',
        cache: false,
        dataType: 'html',
        success: function(data){
          $('#balance_table').replaceWith(data);
        }
      });
    }

    function get_teams_balance_total()
    {
      $.get('/banking/teams_balance_total/' + (-team_id), function(data) {
        $('#teams_balance_total').text('' + data);
      });
    }
    
    function get_league_balance()
    {
      $.get('/banking/league_balance/' + (-team_id), function(data) {
        $('#league_balance').text('' + data);
      });
    }
    
    function get_teams_balance_table()
    {
      $.ajax({
        url: '/banking/teams_balance_table/' + (-team_id),
        cache: false,
        dataType: 'html',
        success: function(data){
          $('#teams_balance_table').replaceWith(data);
        }
      });
    }
    
    function get_dynasty_dollars()
    {
      $.get('/banking/total_dynasty_dollars', function(data) {
        $('#total_dynasty_dollars').text('' + data);
      });
    }
    
    function get_team_balance()
    {
      $.get('/banking/team_balance/' + team_id, function(data) {
        $('#team_account_balance').text('' + data);
      });
    }
    
    function get_team_ledger()
    {
      $.ajax({
        url: '/banking/team_ledger/' + team_id,
        cache: false,
        dataType: 'html',
        success: function(data){
          $('#team_ledger').replaceWith(data);
        }
      });
    }
    
    var current_week = 0;
    
    window.setInterval(sync, 2000);
});