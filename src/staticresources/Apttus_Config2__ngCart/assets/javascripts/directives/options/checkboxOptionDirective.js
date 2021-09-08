(function() {
  var CheckboxOption, CheckboxOptionCtrl;

  CheckboxOptionCtrl = function() {
    var ref;
    this.hasChildren = function() {
      return this.option.isSelected() && (this.nextLevel() < 4) && this.option.optionLine.hasOptions();
    };
    this.getLevel = function() {
      return parseInt(this.level);
    };
    this.nextLevel = function() {
      return this.getLevel() + 1;
    };
    this.price = function() {
      return this.option.price() || '-';
    };
    this.name = this.option.group.data.id;
    this.quantity = ((ref = this.option.optionLine.chargeLines) != null ? ref[0].lineItemSO.Quantity__c : void 0) || this.option.data.DefaultQuantity__c;
    return this;
  };

  CheckboxOptionCtrl.$inject = [];

  CheckboxOption = function(baseUrl, $compile) {
    var addSubGroup, checkboxLink, removeSubGroup;
    addSubGroup = function(scope, element) {
      var compiler, newElement;
      newElement = angular.element(document.createElement('option-groups'));
      newElement.attr('level', "" + (scope.option.nextLevel()));
      newElement.attr('line-item', 'option.option.optionLine');
      compiler = $compile(newElement);
      return compiler(scope, (function(_this) {
        return function(cloned, scope) {
          return element.append(cloned);
        };
      })(this));
    };
    removeSubGroup = function(element) {
      return element.find('option-groups').remove();
    };
    checkboxLink = function(scope, element, attrs) {
      return scope.$watch('option.option.isSelected()', function(newValue, oldValue) {
        if (newValue) {
          if (scope.option.hasChildren()) {
            return addSubGroup(scope, element);
          }
        } else {
          return removeSubGroup(element);
        }
      });
    };
    return {
      scope: {
        option: '=',
        level: '@'
      },
      link: checkboxLink,
      templateUrl: baseUrl + "/templates/directives/options/checkbox-option.html",
      controller: CheckboxOptionCtrl,
      controllerAs: 'option',
      bindToController: true
    };
  };

  CheckboxOption.$inject = ['baseUrl', '$compile'];

  angular.module('ngCPQ').directive('checkboxOption', CheckboxOption);

}).call(this);